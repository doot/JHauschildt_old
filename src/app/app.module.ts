import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { SummaryComponent } from './summary/summary.component';
import { SummaryService } from './summary/summary.service';
import { TempLandingComponent } from './temp-landing/temp-landing.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';
import { NavigationComponent } from './navigation/navigation.component';
import { FooterComponent } from './footer/footer.component';


@NgModule({
  declarations: [
    AppComponent,
    SummaryComponent,
    TempLandingComponent,
    PageNotFoundComponent,
    NavigationComponent,
    FooterComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    NgbModule,
    AppRoutingModule,
  ],
  providers: [SummaryService],
  bootstrap: [AppComponent]
})
export class AppModule { }
