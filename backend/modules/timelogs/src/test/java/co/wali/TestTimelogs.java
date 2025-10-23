package co.wali;

import org.springframework.boot.SpringApplication;

public class TestTimelogs {

	public static void main(String[] args) {
		SpringApplication.from(Timelogs::main).with(TestcontainersConfiguration.class).run(args);
	}

}
