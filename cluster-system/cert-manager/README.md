# How to set up PFSense Wildcard DNS Entries

In the custom section for the DNS Resolver (uses unbound), you need to add the following entries:

```
server:
local-zone: "k3s.noelmiller.dev" redirect
local-data: "k3s.noelmiller.dev 86400 IN A 10.42.0.6"
```

Using the above configuration will allow DNS to automatically route properly to an app created like: `app01.k3s.noelmiller.dev`
Since I have a website at noelmiller.dev (and transparent mode doesn't seem to work...), if I want to do applications at that level like `app01.noelmiller.dev`, I will have to add the DNS entries individually. These will be "production" apps.
