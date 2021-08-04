version 1.0

import "https://raw.githubusercontent.com/mondrian-scwgs/mondrian/mergebamdev/mondrian/wdl/tasks/breakpoint_calling/svaba.wdl" as svaba
import "https://raw.githubusercontent.com/mondrian-scwgs/mondrian/mergebamdev/mondrian/wdl/types/breakpoint_refdata.wdl" as refdata_struct


workflow SvabaWorkflow{
    input{
        File normal_bam
        File normal_bai
        File tumour_bam
        File tumour_bai
        Int num_threads
        BreakpointRefdata ref
    }


    call svaba.runSvaba as run_svaba{
        input:
            normal_bam = normal_bam,
            normal_bai = normal_bai,
            tumour_bam = tumour_bam,
            tumour_bai = tumour_bai,
            num_threads = num_threads,
            reference = ref.reference,
            reference_fa_fai = ref.reference_fa_fai,
            reference_fa_amb = ref.reference_fa_amb,
            reference_fa_ann = ref.reference_fa_ann,
            reference_fa_pac = ref.reference_fa_pac,
            reference_fa_sa = ref.reference_fa_sa,
            reference_fa_bwt = ref.reference_fa_bwt,
    }
    output{
        File output_vcf = run_svaba.output_vcf
    }
}