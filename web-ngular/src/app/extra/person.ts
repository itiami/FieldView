// web-ngular/src/app/features/users/Person.ts


export class Person {

  // id?: number;
  // name?: string;
  // email?: string;

//   constructor(id?: number, name?: string, email?: string) {
//     this.id = id;
//     this.name = name;
//     this.email = email;
//   }


constructor(public id?: number, public name?: string, public email?: string) {}


  getFullName(): string {
    return `${this.name}, Email: ${this.email}`;
  } 

  getEmail(): string {
    this.email = this.email?.toLowerCase();
    return this.email || ''; 
  }

  getId(): number {
    return this.id || 0;
  }
  
}


