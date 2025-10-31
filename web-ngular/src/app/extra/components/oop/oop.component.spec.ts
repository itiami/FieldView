import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OopComponent } from './oop.component';

describe('OopComponent', () => {
  let component: OopComponent;
  let fixture: ComponentFixture<OopComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [OopComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OopComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
