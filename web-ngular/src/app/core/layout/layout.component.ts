import { Component, ViewChild, signal } from '@angular/core';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { MatSidenav } from '@angular/material/sidenav';
import { map, shareReplay } from 'rxjs/operators';
import { Observable } from 'rxjs';

@Component({
  selector: 'fw-layout',
  standalone: false,
  templateUrl: './layout.component.html',
  styleUrl: './layout.component.scss'
})
export class LayoutComponent {
  @ViewChild('snav') snav!: MatSidenav;

  isHandset$: Observable<boolean>;
  appTitle = signal('FieldWise');

  constructor(private bp: BreakpointObserver) {
    this.isHandset$ = this.bp.observe([Breakpoints.XSmall, Breakpoints.Small]).pipe(
      map(state => state.matches),
      shareReplay({ bufferSize: 1, refCount: true })
    );
  }

  toggleNav() {
    this.snav.toggle();
  }

  async onNavigate() {
    const isHandset = await this.isHandset$.pipe(map(v => v)).toPromise();
    if (isHandset) {
      this.snav.close();
    }
  }
}