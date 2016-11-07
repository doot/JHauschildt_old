import { JHauschildtPage } from './app.po';

describe('jhauschildt App', function() {
  let page: JHauschildtPage;

  beforeEach(() => {
    page = new JHauschildtPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
