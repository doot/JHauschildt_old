import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TempLandingComponent } from './temp-landing.component';

describe('TempLandingComponent', () => {
  let component: TempLandingComponent;
  let fixture: ComponentFixture<TempLandingComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TempLandingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TempLandingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
