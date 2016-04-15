describe('app', function() {

  it('title should be corretc', function() {
    browser.get('http://localhost:3000');
    expect(browser.getTitle()).toEqual('Nyymi');
  });

  it('can create an open job and edit description', function() {
    browser.get('http://localhost:3000');
    sign_in_and_create_company()
  });

  function sign_in_and_create_company(){
        element(by.id('login')).click()
        //element(by.id('username')).sendKeys('Pekka')
        //element(by.id('password')).sendKeys('Foobar1')
        //var ptor = protractor.getInstance();
        browser.driver.findElement(by.id('username')).sendKeys('Pekka');

        browser.pause();
  }

});