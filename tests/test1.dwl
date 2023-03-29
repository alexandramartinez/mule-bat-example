import * from bat::BDD
import * from bat::Assertions

var context = bat::Mutable::HashMap() // <--- First, the HashMap
---
describe `Deck of cards` in [
  // Declaring the first test block
  it must "get a new deck of Cards" in [
    GET `$(config.host)new/shuffle/?deck_count=1` with {} assert [
      $.response.status mustEqual 200, // <--- Then a status assertion
      $.response.mime mustEqual "application/json", // <--- And a MIME type assertion
      $.response.body.remaining mustEqual 52 // <--- And a boolean assertion
    ] execute [
      context.set('deck_id', $.response.body.deck_id) // <--- Setting deck_id
    ]
  ],
  // Declaring the second test block
  it should "get two cards" in [
    GET `$(config.host)$(context.get('deck_id'))/draw/?count=2` with {} assert [
      $.response.body.remaining mustEqual 50, // <--- And another boolean assertion
      $.response.body.deck_id mustEqual context.get('deck_id') // <--- And an assertion on the deck_id we set before
    ]
  ],
  // Declaring the third test block
  it should "get two cards" in [
    GET `$(config.host)$(context.get('deck_id'))/draw/?count=2` with {} assert [
      $.response.body.remaining mustEqual 48, // <--- And another boolean assertion
      $.response.body.deck_id mustEqual context.get('deck_id') // <--- And finally, the same assertion on the deck_id
    ] execute [
      log($.response) // <--- Then we’ll log the response
    ]
  ]
]
