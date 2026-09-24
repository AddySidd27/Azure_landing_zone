# Release Checklist

## Documentation

- [ ] All Microsoft design areas appear in the coverage matrix.
- [ ] Every architecture recommendation has a current Microsoft Learn reference.
- [ ] Examples are labelled and do not claim to be Microsoft requirements.
- [ ] Lab and enterprise boundaries are clear.
- [ ] Local Markdown links pass.
- [ ] No tenant IDs, subscription IDs, email addresses, secrets, or screenshots with sensitive values are committed.

## Terraform

- [ ] `terraform fmt -check -recursive` passes.
- [ ] Bootstrap `terraform init -backend=false` and `terraform validate` pass.
- [ ] Platform `terraform init -backend=false` and `terraform validate` pass.
- [ ] Native Terraform tests pass.
- [ ] Provider and module lock files are reviewed.
- [ ] Core-lab and full-platform plans are reviewed.
- [ ] No unexplained replacement, public exposure, broad RBAC, or paid service appears.

## Diagrams

- [ ] Every draw.io source opens successfully.
- [ ] SVG and PNG exports match the source.
- [ ] Text is readable at normal zoom.
- [ ] Arrows, ownership boundaries, and labels do not overlap.
- [ ] Diagrams match the implemented architecture.

## Azure evidence

- [ ] Active tenant and subscription recorded.
- [ ] Core-lab apply completed.
- [ ] Portal and CLI validation completed.
- [ ] Policy compliance observed.
- [ ] Network peering, routes, and DNS tested.
- [ ] Log query and alert delivery tested.
- [ ] Cost and budget checked.
- [ ] Destroy or retention decision completed.

Do not mark a release deployable until the applicable boxes are complete.

