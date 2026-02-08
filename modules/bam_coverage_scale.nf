nextflow.enable.dsl=2

process BAM_COVERAGE_SCALE {
    tag "$key"
    publishDir "${params.outdir}/bamCoverage/$key", pattern:"*", mode: 'copy'

    input:
    tuple val(key), path(bam), path(bai), path(seqDepth)

    output:
    tuple val(key), path("*.bw")
    path("*_scalingInfo.txt")

//add scaling factor
    script:
    """
    depth=$(cat $seqDepth)
    scaleFactor=$(printf "%.2f" "$(echo "scale=10; 1000000/\$depth" | bc -l)")
    echo "Scaling Factor: Constant (1000000) / \$(cat $seqDepth) fragments  = \$scaleFactor" >> ${key}_scalingInfo.txt
    bamCoverage -b $bam -o ${key}_spikenorm.bw --scaleFactor \$scaleFactor
    """
} 