package com.helloworld

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class MainApplication {
    companion object {
        @JvmStatic
        fun main(args: Array<String>) {
            runApplication<MainApplication>(*args)
        }
    }
}