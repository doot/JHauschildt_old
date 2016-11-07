import { Component, OnInit } from '@angular/core';
import { SummaryService } from './summary.service';

@Component({
  selector: 'app-summary',
  providers: [SummaryService],
  templateUrl: './summary.component.html',
  styleUrls: ['./summary.component.css']
})
export class SummaryComponent implements OnInit {

  public summary: Array<any>;

  constructor(private _summaryService: SummaryService) {
    this.summary = _summaryService.getSummary();
  }

  ngOnInit() {
  }

}
