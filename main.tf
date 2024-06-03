/*

module "s3" {
  source      = "./s3"
  bucket_name = var.bucket
}

*/

module "s3" {
  source      = "./modules/s3"
  for_each    = var.bucket
  bucket_name = each.value.bucket_name

}





module "iam" {
  source     = "./modules/iam"
  role       = var.role_name
  depends_on = [module.s3]

}


module "vpc" {
  source             = "./modules/vpc"
  cidr               = var.cidr
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_name = var.public_subnet_name
}

module "ec2" {
  source        = "./modules/ec2"
  subnetid      = module.vpc.public_subnet_id
  ami           = "ami-08ebc9e780cde07dd"
  instance_type = "t2.micro"


}