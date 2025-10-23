package co.wali;

import org.springframework.boot.SpringApplication;

public class TestAudit {

	public static void main(String[] args) {
		SpringApplication.from(Audit::main).with(TestcontainersConfiguration.class).run(args);
	}

}
