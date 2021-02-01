version development

task RunVcf2Maf{
    input{
        File input_vcf
        Directory reference
    }
    command<<<
        if (file ~{input_vcf} | grep -q compressed ) ; then
             gzcat ~{input_vcf} > uncompressed.vcf
        else
            cat ~{input_vcf} > uncompressed.vcf
        fi

        rm -f uncompressed.vep.vcf

        vcf2maf uncompressed.vcf output.maf \
          ~{reference}/homo_sapiens/99_GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz \
          ~{reference}/ExAC_nonTCGA.r0.3.1.sites.vep.vcf.gz \
          ~{reference}
    >>>
    output{
        File output_maf = 'output.maf'
    }
}


task UpdateMafId{
    input{
        File input_maf
        String normal_id
        String tumour_id
    }
    command<<<
        variant_utils update_maf_ids --input ~{input_maf} --tumour_id ~{tumour_id} --normal_id ~{normal_id} --output updated_id.maf
    >>>
    output{
        File output_maf = 'updated_id.maf'
    }
}

task UpdateMafCounts{
    input{
        File input_maf
        File input_counts
    }
    command<<<
        variant_utils update_maf_counts --input ~{input_maf} --counts ~{input_counts} --output updated_counts.maf
    >>>
    output{
        File output_maf = 'updated_counts.maf'
    }
}


task MergeMafs{
    input{
        Array[File] input_mafs
    }
    command<<<
        touch merged.maf
    >>>
    output{
        File output_maf = "merged.maf"
    }
}