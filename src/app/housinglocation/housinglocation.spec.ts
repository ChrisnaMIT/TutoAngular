import { ComponentFixture, TestBed } from '@angular/core/testing';

import {HousingLocation} from './housinglocation';

describe('Housinglocation', () => {
  let component: HousingLocation;
  let fixture: ComponentFixture<HousingLocation>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HousingLocation]
    })
    .compileComponents();

    fixture = TestBed.createComponent(HousingLocation);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
