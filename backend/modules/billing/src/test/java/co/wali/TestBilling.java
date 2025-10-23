package co.wali;

import org.springframework.boot.SpringApplication;

public class TestBilling {

	public static void main(String[] args) {
		SpringApplication.from(Billing::main).with(TestcontainersConfiguration.class).run(args);
	}

}
