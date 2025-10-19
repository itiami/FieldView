package co.wali.env_sec;


import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

@RestController
public class BitwardenSec {
    private String id = "3a06b117-781e-4edc-a290-b37a01559378";

    @SuppressWarnings("resource")
    @GetMapping("/ps")
    public String bwsProcess() throws IOException {
        Process p = new ProcessBuilder("bws", "secret", "get", id, "--output", "json").start();
        String res = new BufferedReader(new InputStreamReader(p.getInputStream()))
                .lines()
                .collect(Collectors.joining("\n"));
        JSONObject jsonObject = new JSONObject(res);
        System.out.println(jsonObject.get("value"));
        System.out.println(jsonObject.toString(4));
        return jsonObject.get("value").toString() ;
    }

}
