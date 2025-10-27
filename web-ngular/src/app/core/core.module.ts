import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LayoutComponent } from './layout/layout.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { LoadingSpinnerComponent } from './components/loading-spinner/loading-spinner.component';



@NgModule({
  declarations: [
    LayoutComponent,
    NotFoundComponent,
    LoadingSpinnerComponent
  ],
  imports: [
    CommonModule
  ]
})
export class CoreModule { }
