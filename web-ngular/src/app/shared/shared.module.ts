// web-ngular/src/app/shared/shared.module.ts
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { SidebarComponent } from './components/sidebar/sidebar.component';
import { FooterComponent } from './components/footer/footer.component';
import{ MatModModule } from '../shared/matmod.module';



@NgModule({
  declarations: [
    SidebarComponent,
    FooterComponent,
  ],
  imports: [
    CommonModule,
    MatModModule,
    RouterModule
  ],
  exports: [
    CommonModule,
    RouterModule,
    SidebarComponent,
    FooterComponent,
    MatModModule  
  ]
})
export class SharedModule { }
