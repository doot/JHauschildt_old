import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { SummaryComponent } from './summary/summary.component';
import { TempLandingComponent } from './temp-landing/temp-landing.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';

const routes: Routes = [
  { path: 'home', component: SummaryComponent },
  { path: '', component: TempLandingComponent, data: { title: 'Nothing to see here...' } },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: []
})
export class AppRoutingModule { }
