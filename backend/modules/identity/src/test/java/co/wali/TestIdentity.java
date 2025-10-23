package co.wali;

import org.springframework.boot.SpringApplication;

public class TestIdentity {

	public static void main(String[] args) {
		SpringApplication.from(Identity::main).with(TestcontainersConfiguration.class).run(args);
	}

}
