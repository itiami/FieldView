package co.wali;

import org.springframework.boot.SpringApplication;

public class TestWorkorders {

	public static void main(String[] args) {
		SpringApplication.from(Workorders::main).with(TestcontainersConfiguration.class).run(args);
	}

}
