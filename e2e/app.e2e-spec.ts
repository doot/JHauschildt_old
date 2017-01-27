import { JhauschildtPage } from './app.po';

describe('jhauschildt App', function() {
  let page: JhauschildtPage;

  beforeEach(() => {
    page = new JhauschildtPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
