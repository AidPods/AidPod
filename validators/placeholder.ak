use cardano/address.{Credential}
use cardano/assets.{PolicyId}
use cardano/certificate.{Certificate}
use cardano/governance.{ProposalProcedure, Voter}
use cardano/transaction.{Transaction, OutputReference}

validator medstakes_validator {
  spend(
    maybe_datum: Option<CampaignDatum>,
    redeemer: Redeemer,
    own_ref: OutputReference,
    tx: Transaction
  ) {
    
    expect Some(datum) = maybe_datum

    match redeemer {
      Donate -> {
       
        True
      }

      ReleaseMilestone { index } -> {
        expect datum.state == 0

        expect Some(ms) = find_milestone_by_index(datum.milestones, index)
        expect ms.released == False

        // Check 2-of-3 signatures
        let signer_count = count_validator_signers(tx, datum.validators)
        expect signer_count >= 2

        // Ensure the transaction pays at least the milestone amount to the beneficiary
        expect tx_pays_to_pubkey(tx, datum.beneficiary, ms.amount)

        let inputs = tx.inputs
        expect Some(own_input) = list.find(inputs, fn(i: Input) {
          i.output_reference == own_ref
        })

        case own_input.output.address.payment_credential {
          Some(Script(script_hash)) -> {
            let maybe_cont = list.find(tx.outputs, fn(o: Output) {
              case o.address.payment_credential {
                Some(Script(sh)) -> sh == script_hash
                _ -> False
              }
            })

            case maybe_cont {
              Some(cont_out) -> {
                expect InlineDatum(new_datum) = cont_out.datum

                // milestone flagged released
                expect list.any(new_datum.milestones, fn(m2: Milestone) {
                  m2.index == index && m2.released == True
                })

                // released_amount incremented correctly
                expect new_datum.released_amount == datum.released_amount + ms.amount

                // Update state: Completed if all milestones released else remain Active
                if all_milestones_released(new_datum.milestones) {
                  expect new_datum.state == 2
                } else {
                  expect new_datum.state == 0
                }
                True
              }
              None -> {
                True
              }
            }
          }
          _ -> fail("expected script input with Script payment credential")
        }
      }

      RefundDonor { to, amount } -> {
        // Only allow refunds when campaign is Failed
        expect datum.state == 3

        // Must be authorized by >= 2 validators
        let signer_count = count_validator_signers(tx, datum.validators)
        expect signer_count >= 2

        expect tx_pays_to_pubkey(tx, to, amount)

        True
      }

      CloseCampaign -> {
        // Only close when all milestones released
        expect all_milestones_released(datum.milestones)
        True
      }
    } 
  }
}

