import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ExtraRoutingModule } from './extra-routing.module';


@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    ExtraRoutingModule
  ], 
  exports: [
    ExtraRoutingModule,
  ]
})
export class ExtraModule { }
