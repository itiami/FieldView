import { Component } from '@angular/core';

@Component({
  selector: 'fw-footer',
  standalone: false,
  templateUrl: './footer.component.html',
  styleUrl: './footer.component.scss'
})
export class FooterComponent {
    get currentYear(): number {
    return new Date().getFullYear();
  }

}
