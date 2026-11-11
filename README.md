# intrufix-proto

gRPC contracts between Intrufix services, plus the Go code generated from
them. Services import the generated code as a Go module:

```go
import accountv1 "github.com/Mayotomiwa/intrufix-proto/gen/go/intrufix/account/v1"
```

| Package               | Served by        | Services and callers                                |
|-----------------------|------------------|-----------------------------------------------------|
| `intrufix.account.v1` | intrufix-account | `UserService`, `ArtisanService` (core, admin): users, artisan profiles and the hireable list; `WithdrawalPinService` (core): checking withdrawal PINs; `AdminService` (admin) |

## Changing a contract

1. Edit the `.proto` file under `proto/`.
2. Run `make lint generate`, then commit the `.proto` change and the
   regenerated `gen/go` code together.
3. CI runs `buf breaking`. Contracts only grow: add fields and RPCs, but never
   renumber, retype or remove a field. To retire one, reserve its number.
4. Tag a release (`git tag v0.2.0 && git push --tags`), then update each
   service with `go get github.com/Mayotomiwa/intrufix-proto@v0.2.0`.

The only tool you need is Go. `make` runs buf and the code generators through
`go run` at pinned versions.

## Using it from a service

The repo is public, so `go get` and `go mod download` fetch it through the
normal Go module proxy. No token or `GOPRIVATE` setting is needed.
