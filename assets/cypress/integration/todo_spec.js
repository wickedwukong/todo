describe('Todo Test', function() {
  it('Enter text into a new todo and enter should create a new todo', function() {
    cy.visit('http://localhost:4000')

    // Get an input, type into it and verify that the value has been updated
    cy.get('.new-task').type('buy milk').should('have.value', 'buy milk')
  }),

  it('Enter text into a new todo', function() {
    cy.visit('http://localhost:4000')

    cy.get('.new-task').type('buy milk{enter}').should('not.have.value', 'buy milk')
    cy.get('#todos div').should(($divs) => {
      expect($divs).to.have.length(1)
      expect($divs.eq(0)).to.contain('buy milk')
    })
  })
})
