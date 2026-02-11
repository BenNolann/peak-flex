nextflow.enable.dsl=2

process MACS3 {
    tag "$key"
    publishDir "${params.outdir}/macs3/$key", pattern:"*", mode: 'copy'

    input:
    tuple val(key), path(bamip), path(baminput)

    output:
    tuple val(key), path("*eak"), emit: peak
    tuple val(key), path("*eak"), path(bamip), emit: peakbam
    tuple val(key), path(bamip), path(baminput), path("*narrowPeak"), emit: peakdiff
    path("*.xls"), emit: excel
    path("*"), emit: allelse

    script:
    """
    macs3 \\
            callpeak \\
            -t $bamip \\
            -c $baminput \\
            -g hs \\
            -n $key \\
            --nomodel \\
            --extsize 200 \\
            --call-summits
    """ 
}