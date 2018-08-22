
# requirements:
#   - gsutil from google cloud SDK
#   - tabix

# download coverage for all chormosomes

for i in `gsutil ls gs://gnomad-public/release/2.0.2/coverage/genomes | grep -v liftover`; do echo ${i}; gsutil cp ${i} .; done

# extract coverage for regions of interest with tabix (only do 1-22 and X)

for i in {1..23};do chr=`echo ${i}|sed 's/23/X/g'`; tabix gnomad.genomes.r2.0.2.chr${chr}.coverage.txt.gz -R ../mandelker_dead_zone_sorted.bed | cut -f1,2,3,4 > chr${chr}_mandelker_dead_zone.txt; done

# concatenate individual chr coverage

cat chr*_mandelker_dead_zone.txt > gnomad_mandelker_dead_zone.txt
