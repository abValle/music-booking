import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { proposalId: Number }
  static targets = ["messages"]

  connect() {
    console.log(`Subscribe to the chatroom with the id ${this.proposalIdValue}.`)

    this.channel = createConsumer().subscriptions.create(
      { channel: "ProposalChannel", id: this.proposalIdValue },
      { received:  data => this.#insertMessageAndScrollDown(data)}
    )
  }

  resetForm(event) {
    console.log("estou aqui")
    event.target.reset()
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }

}
