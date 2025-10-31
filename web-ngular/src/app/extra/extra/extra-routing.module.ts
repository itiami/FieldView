import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { EtlComponent } from '../components/etl/etl.component';
import { OopComponent } from '../components/oop/oop.component';
import { TsBasicComponent } from '../components/ts-basic/ts-basic.component';

const routes: Routes = [
  {path:'etl', component: EtlComponent},
  {path:'ts', component: TsBasicComponent},
  {path:'oop', component: OopComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ExtraRoutingModule { }
