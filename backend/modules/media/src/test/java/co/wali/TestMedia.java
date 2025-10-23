package co.wali;

import org.springframework.boot.SpringApplication;

public class TestMedia {

	public static void main(String[] args) {
		SpringApplication.from(Media::main).with(TestcontainersConfiguration.class).run(args);
	}

}
