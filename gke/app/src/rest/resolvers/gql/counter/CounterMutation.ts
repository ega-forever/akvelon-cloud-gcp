import { Arg, Mutation, Resolver } from 'type-graphql';
import { Inject } from 'typedi';
import { DI } from '../../../../shared/constants/DI';
import { PubSub } from '@google-cloud/pubsub';
import config from '../../../../shared/config'

@Resolver()
export default class CounterMutation {

  @Inject(DI.services.google.pubsub)
  protected readonly googlePubSub: PubSub;

  @Mutation(returnType => Boolean)
  public async increment(
    @Arg('inc', type => Number, { defaultValue: 1 }) inc: number,
  ): Promise<boolean> {
    await this.googlePubSub.topic(config.googlePubSub.topics.increment).publishJSON({
      increment: inc
    });
    return true;
  }

}
