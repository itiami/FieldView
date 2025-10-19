package co.wali.env_sec;


import io.github.cdimascio.dotenv.Dotenv;
import io.github.cdimascio.dotenv.DotenvEntry;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.stream.Collectors;

@RestController
public class EnvConfig {

    private final Dotenv dotenv = Dotenv.load();

    @Autowired
    private Environment env;

    @GetMapping ("/env_App_Properties")
    public String envDetails(){
        return env.toString();
    }


    @GetMapping("/dotEnv")
    public String getEnvUsingDotEnv(){
        StringBuilder stringBuilder = new StringBuilder();
        for (DotenvEntry entry : dotenv.entries()) {
            stringBuilder.append(entry.toString() + "</br>");
            System.out.println(entry.toString());
        }

        return "<pre><code>" + stringBuilder.toString() + "</code></pre>";
    }


    @GetMapping("/bws")
    public String getBwsData() {
        JSONObject jsonObject = new JSONObject(dotenv.entries()
                .stream()
                .collect(Collectors.toMap(DotenvEntry::getKey, DotenvEntry::getValue)));

        jsonObject.toMap().entrySet().forEach(x->{
            String[] val = x.getValue().toString().split(";");
            if (Arrays.stream(val).count() > 1 ){
                JSONArray arr = new JSONArray();
//                System.out.println(x.getKey() + ": " + Arrays.stream(val).count());
                for(String str: val){
                    str = str.trim();
                    arr.put(str);
                }
                jsonObject.put(x.getKey(), arr);
            }

        });
        System.out.println(jsonObject.get("BWS_ACCESS_TOKEN"));
        return "<pre>"+ jsonObject.toString(4) + "</pre>";
    }

}