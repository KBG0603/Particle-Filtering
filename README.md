# Estimation of Spin Observable using Bootstrap Particle Filtering

This repository contains the document and MATLAB codes for estimating the spin observable \( \langle \sigma_x \rangle \) of a two-level quantum system undergoing Rabi oscillations, using the Bootstrap Particle Filter. The project addresses noisy measurements with Gaussian noise and random outliers, as described in the document "Estimation of Spin Observable using Particle Filtering."

## Overview

The document presents an application of the Bootstrap Particle Filter to track the spin observable \( \langle \sigma_x \rangle \) in a two-level spin-1/2 system, governed by a time-independent Hamiltonian in the rotating frame. The MATLAB code implements the simulation of quantum state evolution, noisy measurement generation, and the BPF algorithm, including importance sampling, resampling, and Roulette Wheel selection. The results demonstrate robust estimation with root mean square errors (RMSE) of 0.08, 0.10, and 0.14 for detuning parameters \( \Delta \omega = \omega_0 \), \( 0.5\omega_0 \), and \( 0.1\omega_0 \), respectively.

## Repository Contents

- **Document**: `Particle_filtering.pdf` - The full document detailing the problem, methodology, and results.
- **MATLAB Code**:
  - `simulate_data.m`: Simulates the quantum state evolution and generates noisy measurements with Gaussian noise and random outliers.
  - `particle_filter.m`: Implements the main BPF algorithm for estimating \( \langle S_x \rangle \).
  - `importance_sampling.m`: Updates particle weights based on the measurement model (Gaussian and uniform noise).
  - `resample.m`: Performs resampling to mitigate particle degeneracy.
  - `roulette_wheel.m`: Implements Roulette Wheel selection for sampling indices.
  - **Plot**:  
  - `SpinObservables.pdf`: plots comparing estimated, true, and theoretical spin observables (as shown in Fig. 1 of the document).

## Prerequisites

To run the MATLAB code, you need:
- **MATLAB**: Version R2019a or later (tested on R2023a).
- **Toolboxes**: No additional toolboxes are required (standard MATLAB functions only).
- **Dependencies**: Ensure the MATLAB scripts are in the same directory or added to the MATLAB path.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/KBG0603/Particle-Filtering.git
