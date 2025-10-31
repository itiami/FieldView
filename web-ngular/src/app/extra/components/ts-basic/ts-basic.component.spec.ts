import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TsBasicComponent } from './ts-basic.component';

describe('TsBasicComponent', () => {
  let component: TsBasicComponent;
  let fixture: ComponentFixture<TsBasicComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [TsBasicComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TsBasicComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
