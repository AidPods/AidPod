use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use aiken/transaction.{Transaction, Input, Output, OutputReference}
use aiken/value.{Value}



pub type Milestone = {
  index: Int,
  amount: Int,    
  due: Int,          
  released: Bool
}

pub type CampaignDatum = {
  campaign_id: ByteArray,
  creator: VerificationKeyHash,
  beneficiary: VerificationKeyHash,
  validators: List<VerificationKeyHash>, 
  milestones: List<Milestone>,
  released_amount: Int,
  state: Int,       
  doc_hash: ByteArray
}

pub type Redeemer =
  Donate
| ReleaseMilestone { index: Int }
| RefundDonor { to: VerificationKeyHash, amount: Int }
| CloseCampaign


// Count how many validator pubkey hashes appear in tx.signatories
fn count_validator_signers(tx: Transaction, validators: List<VerificationKeyHash>) -> Int {
  let Transaction { signatories, .. } = tx

  list.fold(validators, 0, fn(acc: Int, v: VerificationKeyHash) {
    if list.has(signatories, v) { acc + 1 } else { acc }
  })
}

// Find a milestone by index
fn find_milestone_by_index(milestones: List<Milestone>, idx: Int) -> Option<Milestone> {
  list.find(milestones, fn(m: Milestone) { m.index == idx })
}

// Check whether all milestones are released
fn all_milestones_released(milestones: List<Milestone>) -> Bool {
  list.all(milestones, fn(m: Milestone) { m.released })
}

// Convert assets.Value -> lovelace (Int)
fn value_lovelace(v: assets.Value) -> Int {
  assets.lovelace_of(v)
}


fn tx_pays_to_pubkey(tx: Transaction, pkh: VerificationKeyHash, amount: Int) -> Bool {
  let Transaction { outputs, .. } = tx

  list.any(outputs, fn(o: Output) {
    case o.address.payment_credential {
      Some(VerificationKey(vk_hash)) ->
        vk_hash == pkh && (value_lovelace(o.value) >= amount)
      _ -> False
    }
  })
}

