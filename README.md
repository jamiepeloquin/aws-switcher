# aws-switcher
A bit of a niche utility, to easily switch from one AWS Profile to another, when you otherwise can’t.

## History
I wrote this package because I have acquired several scripts (both shell and SDK) that do not accommodate for changing your AWS profile when running them. Prior to writing this, switching profiles involved a lot of manual intervention in, and a very messy `~/.aws/credentials` file (looking something like the following).

```ini
[default]
; --> profile-a
region=us-east-1
aws_access_key_id=*************
aws_secret_access_key=*************

; --> profile-b
;region=us-east-2
;aws_access_key_id=*************
;aws_secret_access_key=*************

; --> profile-c
;region=eu-central-1
;aws_access_key_id=*************
;aws_secret_access_key=*************

[profile-b]
region=us-east-2
aws_access_key_id=*************
aws_secret_access_key=*************

[profile-c]
region=eu-central-1
aws_access_key_id=*************
aws_secret_access_key=*************

```

Having to manage duplicate credentials, and uncommenting/commenting out credentials attached to the `[default]` profile was just **ugly and unmanageable**!

## How it works
The **aws-switcher.sh** script takes an **AWS profile name**, and passes it to the `aws configuration` tool, where it fetches your **Access Key** and **Secret Key**. The script then sets the apprpriate environmental variables with those credentials.


## Usage

### Requirements:
- [AWS Account][L1] (you can set one up for free)
- AWS IAM User with a valid set of Access and Secret Keys
- [AWS CLI][L2] installed and configured with profiles *(Note: AWS Shell not officially supported)*

### Set-Up
1. Run the **add-alias.sh** script.<br />`$ ./add-alias.sh`
2. Answer the prompts to configure an alias that will `source` the **aws-switcher.sh**, instead of run it, to set the environment variables to the current shell.
3. A new `alias` will be created in the provided bash/shell-of-your-choice profile (default `.bash_profile`) like:<br />
```shell
## AWS-SWITCHER
alias aws-switcher=". /path/to/this/repo/aws-switcher/aws-switcher.sh"
```

### Switching Profiles
Now that you have the _alias_ configured, you can switch profiles by running the following command, in your Terminal window:<br />`$ aws-switcher my-profile`

This profile will be available to any scripts you run in that current shell session.

[L1]: https://aws.amazon.com "Amazon Web Services"
[L2]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html "Install the AWS CLI"


