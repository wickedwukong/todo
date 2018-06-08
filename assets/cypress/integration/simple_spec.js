describe('My First Test', function() {
  it('Visits the Kitchen Sink', function() {
    cy.visit('http://localhost:4000')

   // Get an input, type into it and verify that the value has been updated
   cy.get('.new-task')
     .type('buy milk')
     .should('have.value', 'buy milk')
  })
})
