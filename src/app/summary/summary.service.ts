import { Injectable } from '@angular/core';

@Injectable()
export class SummaryService {

  summary: Array<any>;

  constructor() {
    this.summary = [
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
  getSummary() {
    return this.summary;
  }
}
