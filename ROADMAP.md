# Roadmap

UGtastic is a service that connects user-group organizers with sponsorship opportunities. We seek to faciliate reliable and respectful communications and access for companies looking to connect with user-group communities.

We need to at a minimum provide a way for potential supporters to register and select sponsorship opportunities that can distribute those funds across user-group Builders

## Minimum Viable Product

- Supporters can submit funds.
- Supports can select from a variety of sponsorship options (one to start)
- Supporters can select conditions for distribution.

- Builders can be deemed eligible for receiving funds by UGtastic admins.
- Builders can be notified when there are funds available.
- Builders can elect whether to accept the conditions.
- Builders can receive the funds paid out through PayPal.

- First option is to display a logo on the User-Group's profile page that the group is sponsored in part by the builder.
- Supporters can see a list of the User-Groups that their funds went to and the amount allocated.
- Builders can see a list of the sponsorship opportunities they've accepted and the amount received.
- All transactions can be viewed by UGtastic admin with the origin of the sponsorship and who accepted/rejected the offer.


## Scenario:

Builder registers and enters PayPal account information

Supporter registers and enters credit card information
Supporter goes to the sponsorship options page
Supporter selects the "Sponsored in part by" option
Supporter selects whether to repeat the offer until cancelled or one-time 30 day offer
Supporter sets the amount to spend on the sponsorship option
Supporter submits the sponsorship

Builder receives an email that there is a pending sponsorship opportunity
Builder receives a site notification that there is a pending sponsorship opportunity
Builder can see a list of all their pending notifications

Builder views the pending sponsorship notification.
Builder sees that the notification is a "Sponsored in part by" opportunity
Builder sees the value of the sponsorship, who is offering the sponsorship and the logo that would be displayed
Builder can accept or reject the offer

If Builder accepts the offer
  Builder will receive the funds into their PayPal account
  Sponsored logo appears on the site
  Builder continues to receive funds and display the logo for the duration of the offer
  Builder can cancel the offer but cannot remove the logo until the end of 30 days

If Builder rejects the offer
  Supporter is refunded the amount spent on the rejected offer minus the UGtastic opportunity fee
  Builder has opportunity to provide a reason for rejection

Supporter receives a monthly list of their offers with information on who accepted and who rejected and why.
Builder receives a monthly email list of offers received, accepted, rejected

# Next step feature ideas

- When a user registers ask them how they're planning to use the site. Are they planning to create a user-group, join local user-groups, or are looking for user-groups to sponsor.
  - Builders: navigate to the create your user-group form
  - Participants: navigate to the user-groups list
  - Supporters: navigate to the sponsorship options form
- More control of how sponsorship opportunities are distributed
  - Supporter can select a geographic region (e.g. US only, Chicago only, Chicago and Milwaukee)
  - Supporter can select a set of interests for which User-Groups should receive sponsorship opportunities (e.g. only Ruby or JavaScript groups)
  - Supporter can blacklist a user-group to never send a sponsorship opportunity to them
  - Builder can blacklist a Supporter to never receive a sponsorship opportunity from them
  - Builder can opt-out of specific sponsorship opportunities (e.g. Never receive "Sponsored in part by" offers)
- Sponsorship opportunities
  - Send a direct email to members of a User-Group through UGtastic
    - Supporter enters a message that they would like to send to a User-Group.
    - Builder receives offer and sees the message that would be sent.
    - If accepted the message would be sent on behalf of the Supporter to the user-group members through UGtastic
    - Some stats could be collected on how the email was received.
    - Q: Should the amount of the offer be contingent on how many members are in the user-group? (Something like $1 for each member who is opted-in to receive sponsored emails)
- Participants can opt-out of receiving sponsored emails

## Long-term feature ideas

- User-Group meetings and events
- Swag sponsorships
- Direct messaging to Builders by Supporters
- Social media promotion
- Job board
