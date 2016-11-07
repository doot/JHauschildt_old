/* tslint:disable:no-unused-variable */

import { TestBed, async } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { AppComponent } from './app.component';
import { NavigationComponent } from './navigation/navigation.component';
import { Routes, RouterModule } from '@angular/router';


describe('App: JHauschildt', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [
        AppComponent,
        NavigationComponent
      ],
      imports: [
        RouterTestingModule,
        RouterModule
      ]
    });
  });

  it('should create the app', async(() => {
    let fixture = TestBed.createComponent(AppComponent);
    let app = fixture.debugElement.componentInstance;
    expect(app).toBeTruthy();
  }));

  it(`should have as title 'JHauschildt'`, async(() => {
    let fixture = TestBed.createComponent(AppComponent);
    let app = fixture.debugElement.componentInstance;
    expect(app.title).toEqual('JHauschildt');
  }));
//  No longer necessary since h1 tag is in another component.
//  Should move this test, but leaving in comment for now
//  it('should render title in a h1 tag', async(() => {
//    let fixture = TestBed.createComponent(AppComponent);
//    fixture.detectChanges();
//    let compiled = fixture.debugElement.nativeElement;
//    expect(compiled.querySelector('h1').textContent).toContain('JHauschildt');
//  }));
});
