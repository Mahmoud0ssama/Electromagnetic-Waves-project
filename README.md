# Gaussian Beam Propagation and Lens Simulation

## Overview
This MATLAB code simulates the propagation of a Gaussian beam through free space and its interaction with a lens at various distances. The code provides insights into the intensity profiles at different planes along the propagation path.

## Initial Gaussian Beam Generation

A Gaussian beam is created in the spatial domain using the following parameters:

- **Wavelength (λ):** The wavelength of the Gaussian beam.
- **Wave Number (k):** The wave number of the beam.
- **Beam Waist (Wo):** The beam waist, representing the minimum beam radius.
- **Spatial Resolution (dx):** The spatial resolution for discretizing the spatial domain.

The beam is then transformed into the spatial frequency domain using the spatial Fourier transform.

## Propagation in Free Space

The spatial frequency representation of the beam is multiplied by the phase term to simulate its propagation through free space at different distances:

- **0Zo:** Initial position.
- **Zo:** One wavelength distance.
- **2Zo:** Two wavelength distances.

The inverse Fourier transform is applied to obtain the beam in the spatial domain at each propagation distance. Intensity profiles are plotted in 2D and 3D for each propagation distance.

## Propagation Through a Lens

A lens effect is simulated by applying a phase term to the beam in the spatial frequency domain. The beam is then transformed back into the spatial domain after passing through the lens at different distances:

- **0.5f:** Half the focal length.
- **f:** Focal length.
- **2f:** Twice the focal length.

Intensity profiles are plotted in 2D and 3D for each lens distance.



