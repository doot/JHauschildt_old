import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SummaryComponent } from './summary.component';
import { SummaryService } from './summary.service';

describe('SummaryComponent', () => {
  let component: SummaryComponent;
  let fixture: ComponentFixture<SummaryComponent>;

  beforeEach(async(() => {
    const summaryServiceStub = {
      getSummary: function () {
        return [
          {
            heading: 'heading 1',
            body:    'body 1'
          },
          {
            heading: 'heading 2',
            body:    'body 2'
          },
          {
            heading: 'heading 3',
            body:    'body 3'
          }
        ];
      }
    };

    TestBed.configureTestingModule({
      declarations: [ SummaryComponent ],
      providers: [
        { provide: SummaryService, useClass: summaryServiceStub }
      ]
    });
    // .compileComponents();

    // const service: SummaryService = new SummaryService();
    fixture = TestBed.createComponent(SummaryComponent);
    component = fixture.componentInstance;
    // summaryService = fixture.debugElement.injector.get(SummaryService);
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
