version 1.0

# Define the workflow and inputs
workflow validation_vcf {
    input {
        File test_vcf
        File test_index
        File reference_vcf
        File reference_index
        File reference_bed
        File reference_genome
        File genome_index
        String output_folder
    }

# Call the validate task
    call validate {
        input:
            test_vcf = test_vcf,
            test_index = test_index,
            reference_vcf = reference_vcf,
            reference_index = reference_index, 
            reference_bed = reference_bed,
            reference_genome = reference_genome,
            genome_index = genome_index, 
            output_folder = output_folder
    }

# Define the outputs
    output {
        File validation_report = validate.validation_report
        File validation_metrics = validate.validation_metrics
        File extended_summary = validate.extended_summary
        File roc_all = validate.roc_all
        File roc_indel_all = validate.roc_indel_all
        File roc_indel_pass = validate.roc_indel_pass
        File roc_snp_all = validate.roc_snp_all 
        File roc_snp_pass = validate.roc_snp_pass
        File run_info = validate.run_info
        File passed_variants = validate.passed_variants
        File passed_variants_index = validate.passed_variants_index
    }
}

# Define task validate
task validate {
    input {
        File test_vcf
        File test_index
        File reference_genome
        File genome_index
        File reference_vcf
        File reference_index
        File reference_bed
        String output_folder
    }

# Define base names for output files
    String test_base = basename(test_vcf, ".vcf")
    String ref_base = basename(reference_vcf, ".vcf")

## Create output directory and run hap.py
    command <<<
        mkdir -p ~{output_folder}

        /opt/hap.py/bin/hap.py \
            ~{reference_vcf} \
            ~{test_vcf} \
            -r ~{reference_genome} \
            --false-positives ~{reference_bed} \
            -o ~{output_folder}/~{test_base}.~{ref_base}
    >>>

## Define output files
    output {
        File validation_report = "~{output_folder}/~{test_base}.~{ref_base}.summary.csv"
        File validation_metrics = "~{output_folder}/~{test_base}.~{ref_base}.metrics.json.gz"
        File extended_summary = "~{output_folder}/~{test_base}.~{ref_base}.extended.csv"
        File roc_all = "~{output_folder}/~{test_base}.~{ref_base}.roc.all.csv.gz"
        File roc_indel_all = "~{output_folder}/~{test_base}.~{ref_base}.roc.Locations.INDEL.csv.gz"
        File roc_indel_pass = "~{output_folder}/~{test_base}.~{ref_base}.roc.Locations.INDEL.PASS.csv.gz"
        File roc_snp_all = "~{output_folder}/~{test_base}.~{ref_base}.roc.Locations.SNP.csv.gz"
        File roc_snp_pass = "~{output_folder}/~{test_base}.~{ref_base}.roc.Locations.SNP.PASS.csv.gz"
        File run_info = "~{output_folder}/~{test_base}.~{ref_base}.runinfo.json"
        File passed_variants = "~{output_folder}/~{test_base}.~{ref_base}.vcf.gz"
        File passed_variants_index = "~{output_folder}/~{test_base}.~{ref_base}.vcf.gz.tbi"
    }

## # Runtime settings (Docker image to use and resources allocated)
    runtime {
        docker: "us-central1-docker.pkg.dev/cool-benefit-817/guelph-internship/happy:0.3.15"
        cpu: 8
        memory: "4 GB"
        disks: "local-disk 20 HDD"
        bootDiskSizeGb: 20
    }
}
