use cardano/transaction.{OutputReference}

test aidpod_validator_test() {
  let output_reference =
    OutputReference { transaction_id: #"", output_index: 0 }

  let placeholder_transaction =
    Transaction {
      inputs: [],
      reference_inputs: [],
      outputs: [],
      fee: 0,
      mint: assets.zero,
      certificates: [],
      withdrawals: [],
      validity_range: interval.everything,
      extra_signatories: [],
      redeemers: [],
      datums: dict.empty,
      id: #"",
      votes: [],
      proposal_procedures: [],
      current_treasury_amount: None,
      treasury_donation: None,
    }
  aidpod_validator.spend(None, Void, output_reference, placeholder_transaction)
}
