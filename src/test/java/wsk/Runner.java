package wsk;

import com.intuit.karate.junit5.Karate;

class Runner {
    
    // Este runner ejecutara todos los *.feature que existan en los sub directorios
    @Karate.Test
    Karate testAll() {
        return new Karate().relativeTo(getClass());
    }
    
}
