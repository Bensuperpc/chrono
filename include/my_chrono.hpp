/*
** EPITECH PROJECT, 2019
** epitech, 2019
** File description:
** >my_chrono.h
*/

#ifndef _CHRONO_H_
#define _CHRONO_H_

#include <chrono>
#include <iostream>
#include <vector>

typedef std::chrono::high_resolution_clock Clock;

class my_chrono {
public:
    // Fonctions
    void reset();
    void start();
    void stop();
    void add_step();
    size_t elapsed_ns();
    size_t elapsed_ms();
    std::vector<size_t> get_steps();

    // void generate_leafs();

    // Constructeurs
    my_chrono();

    // Destructeurs
    ~my_chrono();

private:
    // Variables
    Clock::time_point start_time = Clock::now();
    Clock::time_point stop_time = Clock::now();

    // For vector step by step
    std::vector<Clock::time_point> step;

protected:
};

#endif