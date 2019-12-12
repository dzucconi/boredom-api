# boredom-api

Boredom is Deep and Mysterious

## Meta

- **State**: production
- **Production**:
  - **URL**: https://damonzucconi-boredom-api.herokuapp.com/graphiql
- **Host**: https://dashboard.heroku.com/apps/damonzucconi-boredom-api
- **Deploys**: Merged PRs to `dzucconi/boredom-api#master` are automatically deployed to production. [Manually trigger a deploy](https://dashboard.heroku.com/apps/damonzucconi-boredom-api/deploy)

## Getting Started

```graphql
{
  questions(limit: 5, sortBy: RANDOM, crawled: true) {
    ...QuestionFragment
    related {
      ...QuestionFragment
    }
  }
}

fragment QuestionFragment on Question {
  body
}
```
