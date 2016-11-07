/* tslint:disable:no-unused-variable */

import { TestBed, async } from '@angular/core/testing';
import { SummaryComponent } from './summary.component';
import { SummaryService } from './summary.service';

describe('Component: Summary', () => {
  it('should create an instance', () => {
    let service: SummaryService = new SummaryService();
    let component: SummaryComponent = new SummaryComponent(service);
    expect(component).toBeTruthy();
  });
});
