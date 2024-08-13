# Summer Internship Workflow Repository

This repository contains the workflows and associated scripts developed during my summer internship program at DNAstack. The main focus of the project was to create, test, and validate genomic variant identification pipelines using Workflow Description Language (WDL) and Docker.

## Project Overview

During the internship, the primary task was to validate variant identification pipelines, specifically using the PacBio Whole Genome Sequencing (WGS) data. The validation process involved comparing pipeline outputs against gold standard reference files to assess performance metrics such as recall, precision, and F1 score. The workflows developed in this repository were instrumental in automating these comparisons and ensuring the reliability of the pipeline used.

## Repository Structure

Workflows: Contains the WDL scripts used for various validation tasks.
Dockerfiles: Includes Docker configurations to create reproducible environments for running the workflows.

## Getting Started

To run the workflows in this repository, you will need to have the following installed:

WDL: The Workflow Description Language for running the scripts.
Cromwell: A workflow execution engine that supports WDL.
Docker: To ensure that the workflows run in a consistent environment across different systems.

## Acknowledgments

Special thanks to the DNAstack team for their guidance and support throughout the internship. This project wouldn't have been possible without their expertise and resources.
