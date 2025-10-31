import { Component } from '@angular/core';
import { Person } from '../../person';

@Component({
  selector: 'fw-etl',
  standalone: false,
  templateUrl: './etl.component.html',
  styleUrl: './etl.component.scss'
})
export class EtlComponent {

    
person: Person = new Person();

  run(): void {
    this.person.id = 54813545;
    this.person.name = 'My Name';
    this.person.email = 'add@mail.com';
    console.log(`User Info: ${this.person.getFullName()}`);
  }

  ngOnInit(): void {
    this.run();
  }

}
